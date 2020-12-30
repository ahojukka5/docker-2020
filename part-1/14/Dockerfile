FROM ruby:2.6.0

RUN apt-get update && apt-get install -y nodejs

RUN git clone https://github.com/docker-hy/rails-example-project.git /app

WORKDIR /app

RUN bundle
ENV RAILS_ENV=production

# We have lost the master key. Let's create new encrypted
# credentials. We have to temporarily add config.secret_key to
# config/environments/production.rb, otherwise we get error
COPY add_temporary_secret_key.patch .
RUN patch -u -b config/environments/production.rb -i add_temporary_secret_key.patch

# Master key will be stored inside container
RUN rm config/credentials.yml.enc
RUN EDITOR=true rails credentials:edit

RUN mv config/environments/production.rb.orig config/environments/production.rb

RUN rails db:migrate
RUN rake assets:precompile

ENTRYPOINT ["rails"]
CMD ["s", "-e", "production"]

