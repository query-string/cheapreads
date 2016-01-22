Rails.application.config.middleware.use OmniAuth::Builder do
  configure { |config| config.path_prefix = "/authentication" }
  provider :goodreads, ENV["GOODREADS_KEY"], ENV["GOODREADS_SECRET"]
end
