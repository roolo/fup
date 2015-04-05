require 'sinatra'

module FUP
  class App < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/upload' do
      FileUtils.mv  params['uploaded-file'][:tempfile].path,
                    'uploads/' + params['uploaded-file'][:filename]

      return 'The file was successfully uploaded!'
    end
  end
end

