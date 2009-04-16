require 'rforce'

desc 'Perform a crude comparison of the various response parsers'
task :timing do
  fname = File.join(File.dirname(__FILE__), '../spec/soap-response.xml')
  contents = File.open(fname) {|f| f.read}

  [:SoapResponseRexml,
   :SoapResponseExpat,
   :SoapResponseHpricot].each do |name|
    begin
      klass = RForce.const_get name
      started_at = Time.now
      klass.new(contents).parse
      elapsed = Time.now - started_at
      puts "#{klass}: #{elapsed}"
    rescue NameError
      # no-op
    end
  end
end
