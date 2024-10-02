from sqlalchemy import create_engine, MetaData, Table, select
import pandas as pd

# Database configuration: Update with your MySQL credentials
DATABASE_URI = 'mysql+pymysql://root:Password1234@localhost/ecommerce'

# Creating the SQLAlchemy engine
engine = create_engine(DATABASE_URI)

# Connect to the database and fetch data
def fetch_orders():
    # Reflect metadata from the database
    metadata = MetaData()

    # Use autoload_with to reflect the table structure
    orders = Table('orders', metadata, autoload_with=engine)

    # Fetch orders data: Select specific columns from the table
    with engine.connect() as conn:
        # Pass columns individually to select()
        query = select(orders.c.order_id, orders.c.user_id, orders.c.order_date,
                       orders.c.total_amount, orders.c.payment_status)

        result = conn.execute(query)
        df = pd.DataFrame(result.fetchall(), columns=result.keys())

    return df

# Clean and transform data
def clean_transform_data():
    df_orders = fetch_orders()

    # Cleaning: Drop duplicates and handle missing data
    df_orders.drop_duplicates(inplace=True)
    df_orders.fillna(value={'payment_status': 'Pending'}, inplace=True)

    # Transformation: Add 'order_month' column
    df_orders['order_month'] = pd.to_datetime(df_orders['order_date']).dt.to_period('M')

    # Print for verification
    print(df_orders.head())

# Example function call
if __name__ == "__main__":
    clean_transform_data()
