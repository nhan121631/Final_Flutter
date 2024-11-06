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
        p.thumbnail AS image_name  -- Thêm trường image_name
    FROM 
        orders o 
    JOIN 
        orderitem oi ON o.id = oi.order_id 
    JOIN 
        product p ON oi.product_id = p.id 
    JOIN 
        category c ON c.id = p.category_id
    WHERE 
        o.user_id = %s AND o.status <> 3;
    """
    
    cursor.execute(query, (user_id,))
    result = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    # Chuyển đổi dữ liệu thành DataFrame
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
        p.thumbnail AS image_name  -- Thêm trường image_name
    FROM 
        product p 
    JOIN 
        category c ON c.id = p.category_id;
    """
    
    cursor.execute(all_products_query)
    all_products_result = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    # Chuyển đổi dữ liệu thành DataFrame
    columns = ['product_id', 'product_name', 'sell_price', 'description', 'category_name', 'image_name']
    return pd.DataFrame(all_products_result, columns=columns)

# Hàm trích xuất đặc trưng hình ảnh từ URL
def extract_image_features(image_url):
    model = VGG16(weights='imagenet', include_top=False, pooling='avg')

    # Kiểm tra và thêm giao thức nếu cần
    if not image_url.startswith(('http://', 'https://')):
        image_url = 'http://localhost:3333/flutter.com/image/' + image_url  # Hoặc 'https://' tùy thuộc vào URL bạn có

    # Tải hình ảnh từ URL
    response = requests.get(image_url)
    
    if response.status_code != 200:
        raise ValueError(f"Không thể tải hình ảnh từ URL: {image_url}. Mã trạng thái: {response.status_code}")

    # Đọc hình ảnh từ dữ liệu nhị phân
    img_array = np.asarray(bytearray(response.content), dtype=np.uint8)
    img = cv2.imdecode(img_array, cv2.IMREAD_COLOR)
    
    # Kiểm tra xem hình ảnh đã được đọc thành công chưa
    if img is None:
        raise ValueError(f"Không thể đọc hình ảnh từ URL: {image_url}")

    img = cv2.resize(img, (224, 224))
    img = np.expand_dims(img, axis=0)
    img = preprocess_input(img)
    
    features = model.predict(img)
    return features.flatten()

# Hàm gợi ý sản phẩm
def recommend_based_on_purchases(purchased_products_df, all_products_df):
    recommended_products = []
    
    # Làm sạch mô tả sản phẩm đã mua
    purchased_products_df['description'] = purchased_products_df['description'].apply(clean_html)

    # Tính toán TF-IDF cho mô tả sản phẩm
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(all_products_df['description'])
    
    # Tính độ tương đồng cosine cho mô tả văn bản
    cosine_sim_text = cosine_similarity(tfidf_matrix, tfidf_matrix)

    # Tính toán độ tương đồng hình ảnh cho tất cả sản phẩm
    image_features = []
    for image_url in all_products_df['image_name']:
        features = extract_image_features(image_url)
        image_features.append(features)
    image_features = np.array(image_features)

    # Tính độ tương đồng cosine cho hình ảnh
    cosine_sim_image = cosine_similarity(image_features)

    # Lặp qua từng sản phẩm đã mua để tìm sản phẩm gợi ý
    for _, row in purchased_products_df.iterrows():
        product_name = row['product_name']
        idx = all_products_df.index[all_products_df['product_name'] == product_name][0]

        # Lấy các độ tương đồng cho sản phẩm đó (văn bản và hình ảnh)
        sim_scores_text = list(enumerate(cosine_sim_text[idx]))
        sim_scores_image = list(enumerate(cosine_sim_image[idx]))
        
        # Kết hợp độ tương đồng (có thể điều chỉnh trọng số nếu cần)
        combined_sim_scores = [(i, (sim_scores_text[i][1] + sim_scores_image[i][1]) / 2) for i in range(len(all_products_df))]

        # Sắp xếp sản phẩm theo độ tương đồng giảm dần
        combined_sim_scores = sorted(combined_sim_scores, key=lambda x: x[1], reverse=True)
        
        # Lấy top 5 sản phẩm gợi ý (bỏ qua sản phẩm đã được mua)
        combined_sim_scores = combined_sim_scores[1:6]  # Bỏ qua sản phẩm đã mua
        
        # Thêm ID, tên sản phẩm vào danh sách
        for i in combined_sim_scores:
            recommended_products.append((all_products_df['product_id'].iloc[i[0]], all_products_df['product_name'].iloc[i[0]]))
    
    # Trả về danh sách sản phẩm gợi ý duy nhất (chỉ ID và tên sản phẩm)
    return list(set(recommended_products))

# Lấy danh sách sản phẩm đã mua và tất cả sản phẩm
user_id = 10  # Thay bằng user_id thực tế
purchased_products_df = get_purchased_products(user_id)
all_products_df = get_all_products()

# Gợi ý sản phẩm
recommended_products = recommend_based_on_purchases(purchased_products_df, all_products_df)
print("Sản phẩm gợi ý từ sản phẩm đã mua:")
for product_id, product_name in recommended_products:
    print(f"ID: {product_id}, Tên: {product_name}")
