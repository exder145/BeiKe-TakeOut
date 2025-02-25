import pandas as pd
from sklearn.neighbors import NearestNeighbors
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

class RecommendationSystem:
    def __init__(self, order_data):
        self.order_data = order_data
        self.model = NearestNeighbors(n_neighbors=5)  # 选择5个邻居
        self.scaler = StandardScaler()  # 标准化器

    def preprocess_data(self):
        # 数据预处理，例如将类别特征转换为数值特征
        self.order_data = pd.get_dummies(self.order_data, columns=['dish_name', 'restaurant'])
        
        # 处理缺失值
        self.order_data.fillna(0, inplace=True)

        # 标准化数值特征
        self.scaler.fit(self.order_data)
        self.order_data = self.scaler.transform(self.order_data)

    def fit(self):
        self.preprocess_data()
        self.model.fit(self.order_data)

    def recommend(self, user_order):
        # 将用户的订单数据转换为适合模型的格式
        user_order = pd.get_dummies(user_order, columns=['dish_name', 'restaurant'])
        user_order = user_order.reindex(columns=self.order_data.columns, fill_value=0)
        
        # 标准化用户订单数据
        user_order = self.scaler.transform(user_order)

        distances, indices = self.model.kneighbors(user_order)
        return self.order_data.iloc[indices.flatten()]

    def evaluate_model(self):
        # 交叉验证和模型评估功能
        X_train, X_test = train_test_split(self.order_data, test_size=0.2, random_state=42)
        self.model.fit(X_train)
        score = self.model.score(X_test)
        return score

    def update_model_with_feedback(self, feedback_data):
        # 根据用户反馈更新模型
        # feedback_data 应该是一个 DataFrame，包含用户的反馈信息
        self.order_data = pd.concat([self.order_data, feedback_data], ignore_index=True)
        self.fit()  # 重新训练模型

# 示例用法
if __name__ == "__main__":
    # 假设我们有一个包含历史订单数据的 DataFrame
    order_data = pd.DataFrame({
        'dish_name': ['pizza', 'sushi', 'burger', 'pasta', 'salad'],
        'restaurant': ['rest1', 'rest2', 'rest1', 'rest3', 'rest2'],
        'price': [10, 15, 8, 12, 9]
    })

    # 创建推荐系统实例
    recommender = RecommendationSystem(order_data)

    # 训练模型
    recommender.fit()

    # 假设用户的订单数据
    user_order = pd.DataFrame({
        'dish_name': ['pizza'],
        'restaurant': ['rest1']
    })

    # 获取推荐结果
    recommendations = recommender.recommend(user_order)

    # 打印推荐结果
    print("推荐的菜品：")
    print(recommendations) 