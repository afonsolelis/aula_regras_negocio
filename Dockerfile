# Dockerfile para a aplicação Rails
FROM ruby:3.1.2

# Definir diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm

# Instalar Yarn
RUN npm install -g yarn

# Copiar Gemfile e Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN gem install bundler:2.2.28
RUN bundle install

# Copiar o restante do código da aplicação
COPY . .

# Adicionar um script para aguardar o PostgreSQL
COPY wait-for-postgres.sh /wait-for-postgres.sh
RUN chmod +x /wait-for-postgres.sh

# Configurar o banco de dados padrão
CMD ["/wait-for-postgres.sh", "rails", "db:create", "&&", "rails", "server", "-b", "0.0.0.0"]
