require 'sinatra'

module FUP
  class App < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/upload' do
      File.open('uploads/' + params['uploaded-file'][:filename], 'w') do |f|
        f.write(params['uploaded-file'][:tempfile].read)
      end
      return 'The file was successfully uploaded!'

    end
  end
end

