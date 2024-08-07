from flask import Flask, request, render_template
from elasticsearch import Elasticsearch
import logging

app = Flask(__name__)

# Initialize Elasticsearch client with scheme
es = Elasticsearch(
    [{'host': 'localhost', 'port': 9200, 'scheme': 'http'}]
)

logging.basicConfig(level=logging.DEBUG)

@app.route('/', methods=['GET', 'POST'])
def index():
    query = request.form.get('query', '')
    year = request.form.get('year', '2024')
    results = []

    if query:
        index_pattern = f'tor-{year}*'
        logging.debug(f"Searching in index: {index_pattern} with query: {query}")

        try:
            search_result = es.search(index=index_pattern, body={
                "query": {
                    "match": {
                        "content": query
                    }
                },
                "_source": ["content", "url", "domain", "title"]
            }, size=50)

            results = search_result['hits']['hits']
            logging.debug(f"Search results: {results}")

        except Exception as e:
            logging.error(f"Error querying Elasticsearch: {e}")

    return render_template('index.html', query=query, results=results, year=year)

if __name__ == '__main__':
    app.run(debug=True)
