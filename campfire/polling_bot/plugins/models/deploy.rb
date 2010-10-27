# used by DeployPlugin
class Deploy
  include DataMapper::Resource
  property :id,                 Serial
  property :who,                String, :index => true
  property :souschef_restarted, Boolean, :index => true
  property :revision,           String, :index => false
  property :timestamp,          Time, :required => true, :index => true
end

