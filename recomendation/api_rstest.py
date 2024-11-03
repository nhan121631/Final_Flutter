import mysql.connector
import pandas as pd
from bs4 import BeautifulSoup
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import requests
import numpy as np
import cv2
from tensorflow.keras.applications import VGG16
from tensorflow.keras.applications.vgg16 import preprocess_input
from flask import Flask, jsonify, request
from concurrent.futures import ThreadPoolExecutor

app = Flask(__name__)

# Hàm làm sạch HTML
def clean_html(html_text):
    soup = BeautifulSoup(html_text, "html.parser")
    return soup.get_text()

# Thiết lập kết nối đến cơ sở dữ liệu
def get_db_connection():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="",
        database="tmdt",
        port=3306
    )

# Hàm lấy danh sách sản phẩm đã mua của người dùng
# Hàm lấy danh sách sản phẩm đã mua của người dùng
def get_purchased_products(user_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    query = """
    SELECT 
        p.id AS product_id,  
        p.name AS product_name,
        p.sell_price,
        p.description,
        c.name AS category_name,
        p.thumbnail AS image_name
    FROM 
        orderitem oi
    JOIN 
        orders o ON oi.order_id = o.id
    JOIN 
        product p ON oi.product_id = p.id 
    JOIN 
        category c ON c.id = p.category_id
    WHERE 
        o.id = (
            SELECT id
            FROM orders
            WHERE user_id = %s AND status <> 3
            ORDER BY createddate DESC
            LIMIT 1
        );
    """

    cursor.execute(query, (user_id,))
    result = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    columns = ['product_id', 'product_name', 'sell_price', 'description', 'category_name', 'image_name']
    return pd.DataFrame(result, columns=columns)

# Hàm lấy tất cả sản phẩm
def get_all_products():
    conn = get_db_connection()
    cursor = conn.cursor()
    
    all_products_query = """
    SELECT 
        p.id AS product_id,  
        p.name AS product_name,
        p.sell_price,
        p.description,
        c.name AS category_name,
        p.thumbnail AS image_name
    FROM 
        product p 
    JOIN 
        category c ON c.id = p.category_id;
    """
    
    cursor.execute(all_products_query)
    all_products_result = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    columns = ['product_id', 'product_name', 'sell_price', 'description', 'category_name', 'image_name']
    return pd.DataFrame(all_products_result, columns=columns)

# Hàm tải hình ảnh từ URL
def load_image(url):
    if not url.startswith(('http://', 'https://')):
        url = 'http://localhost:3333/flutter.com/image/' + url  

    response = requests.get(url)
    if response.status_code == 200:
        img_array = np.asarray(bytearray(response.content), dtype=np.uint8)
        img = cv2.imdecode(img_array, cv2.IMREAD_COLOR)
        return img
    return None

# Hàm trích xuất đặc trưng hình ảnh từ nhiều URL
def extract_image_features(image_urls):
    model = VGG16(weights='imagenet', include_top=False, pooling='avg')
    images = []

    with ThreadPoolExecutor() as executor:
        loaded_images = list(executor.map(load_image, image_urls))

    for img in loaded_images:
        if img is not None:
            img = cv2.resize(img, (128, 128))  
            img = np.expand_dims(img, axis=0)
            img = preprocess_input(img)
            features = model.predict(img)
            images.append(features.flatten())

    return np.array(images)

# Hàm tính tương đồng tổng hợp
def calculate_combined_similarity(all_products_df):
    vectorizer = TfidfVectorizer(stop_words='english')
    combined_text = all_products_df['product_name'] + " " + all_products_df['category_name'] + " " + all_products_df['description']
    all_products_df['combined_text_cleaned'] = combined_text.apply(clean_html)
    tfidf_matrix = vectorizer.fit_transform(all_products_df['combined_text_cleaned'])
    text_similarity = cosine_similarity(tfidf_matrix)
    
    prices = all_products_df['sell_price'].values.reshape(-1, 1)
    price_similarity = cosine_similarity(prices)
    
    image_urls = all_products_df['image_name'].tolist()
    image_features = extract_image_features(image_urls)
    image_similarity = cosine_similarity(image_features)
    
    combined_similarity = text_similarity + price_similarity + image_similarity
    return combined_similarity

# Hàm gợi ý sản phẩm
def recommend_based_on_purchases(purchased_products_df, all_products_df):
    combined_similarity = calculate_combined_similarity(all_products_df)
    recommended_products = set()

    for _, purchased_product in purchased_products_df.iterrows():
        purchased_product_id = purchased_product['product_id']
        product_index = all_products_df[all_products_df['product_id'] == purchased_product_id].index[0]
        similarity_scores = list(enumerate(combined_similarity[product_index]))
        similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)

        # Lấy 5 sản phẩm có độ tương đồng cao nhất
        top_similar_products = similarity_scores[1:6]  # Bỏ qua sản phẩm đầu tiên vì đó chính là sản phẩm hiện tại
        for i, score in top_similar_products:
            recommended_products.add(all_products_df.iloc[i]['product_id'])

    # Giữ lại 5 sản phẩm có độ tương đồng cao nhất từ các sản phẩm gợi ý
    recommended_products = sorted(recommended_products, key=lambda x: max([combined_similarity[all_products_df[all_products_df['product_id'] == x].index[0], idx] for idx in all_products_df.index]), reverse=True)[:5]

    return recommended_products

@app.route('/recommend', methods=['GET'])
def recommend():
    user_id = request.args.get('user_id', type=int)
    if user_id is None:
        return jsonify({"error": "user_id is required"}), 400

    purchased_products_df = get_purchased_products(user_id)
    all_products_df = get_all_products()

    recommended_products = recommend_based_on_purchases(purchased_products_df, all_products_df)

    # Chuyển đổi danh sách recommended_product_ids sang danh sách kiểu int
    recommended_product_ids = [int(product_id) for product_id in recommended_products]

    return jsonify({"recommended_product_ids": recommended_product_ids})

if __name__ == '__main__':
    app.run(debug=True)
