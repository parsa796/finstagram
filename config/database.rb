configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  if Sinatra::Application.development?
    set :database, {
      adapter: "sqlite3",
      database: "db/db.sqlite3"
    }
  
  else
    db_url = 'postgres://feuclndcultqwv:c4428dcf85fe8d46164742abc99e3e12e1b9d0dc5a4dd747e185d55a6b47563f@ec2-52-0-155-79.compute-1.amazonaws.com:5432/ddk77dv7qcvrjl'
    db = URI.parse(ENV['DATABASE_URL'] || db_url)
    set :database, {
      adapter: "postgresql",
      host: db.host,
      username: db.user,
      password: db.password,
      database: db.pathp[1..-1],
      encoding: 'utf8'

    }
  end
 
  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
