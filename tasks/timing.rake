require 'rforce'

desc 'Perform a crude comparison of the three response parsers'
task :timing do
  fname = File.join(File.dirname(__FILE__), '../spec/soap-response.xml')
  contents = File.open(fname) {|f| f.read}

  [RForce::SoapResponse,
   RForce::SoapResponseExpat,
   RForce::SoapResponseHpricot].each do |klass|
    started_at = Time.now
    results = klass.new(contents)
    elapsed = Time.now - started_at
    puts "#{klass}: #{elapsed}"
  end
end
