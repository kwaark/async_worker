import os
import faust
from typing import Optional

# Definindo a variável de ambiente para o URL do broker Kafka.
BROKER_URL = os.getenv('BROKER_URL', 'kafka://kafka:9092')

# Inicializando a aplicação Faust com o nome 'async_worker' e o broker Kafka.
app = faust.App(
    'async_worker',
    broker=BROKER_URL,
    store='memory://',
)

# Definindo o modelo de dados que será utilizado nas mensagens Kafka.
class ItemModel(faust.Record, serializer='json'):
    item_id: int
    q: Optional[str]

# Definindo o canal e o tópico que o Faust irá ouvir.
channel = app.topic('items_topic', value_type=ItemModel)

# Definindo o agente que irá processar as mensagens recebidas no tópico.
@app.agent(channel)
async def process(stream):
    async for event in stream:
        # Aqui você pode adicionar o processamento que deseja fazer com o evento.
        print(f'Received: {event!r}')
