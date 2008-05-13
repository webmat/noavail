require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

=begin
TODO for specs
- 
=end

describe NoAvail, 'parameter interpreter' do

  DEFAULT_EXT  = [".com", ".net", ".org"]
  DEFAULT_HEAD = ['Avail?'] + DEFAULT_EXT

  it "should return 3 empty arrays when there's nothing specified" do
    read_params([]).should == [[], [], []]
  end

  it "should interpret as names if no '.' is specified" do
    read_params(%w{name1}).should       == [['name1'],          DEFAULT_EXT, DEFAULT_HEAD]
    read_params(%w{name1 name2}).should == [['name1', 'name2'], DEFAULT_EXT, DEFAULT_HEAD]
  end

  it "should interpret extensions after a '.'" do
    read_params(%w{name1 . ca}).should == [['name1'], DEFAULT_EXT + ['.ca'], DEFAULT_HEAD + ['.ca']]
  end

  it "should add a '.' to the extension only when necessary" do
    read_params(%w{name1 . .ca}).should == [['name1'], DEFAULT_EXT + ['.ca'], DEFAULT_HEAD + ['.ca']]
  end

  it "should support complex extensions" do
    read_params(%w{name1 . qc.ca}).should == [['name1'], DEFAULT_EXT + ['.qc.ca'], DEFAULT_HEAD + ['.qc.ca']]
  end

end