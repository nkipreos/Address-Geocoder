class NormalizerController < ApplicationController
include ApplicationHelper
  def index
  end

  def upload
  	file = params[:file]
  	tmp = File.open('tmp.xls','wb')
  	tmp.write(file.read)
  	tmp.close
	  outfile = generateExcel('tmp.xls')
	  send_data File.open(outfile).read, :filename => 'Coordenadas.xls', :type =>  "application/vnd.ms-excel"
	  `rm tmp.xls`
	  `rm #{outfile}`
  end

end
