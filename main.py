import pandas as pd
from sqlalchemy import create_engine, DateTime

engine = create_engine('postgresql://postgres:example@localhost:5432/postgres')

df = pd.read_csv('covid-data.csv')
df['date'] = pd.to_datetime(df['date'])

engine.execute("DROP TABLE IF EXISTS covid")

df.to_sql('covid', con=engine,dtype={'date': DateTime()})


