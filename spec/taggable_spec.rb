require 'spec_helper'

describe TaggableModel do
  #let (:model) { TaggableModel.new(name: "post") }
 
  it { should have_many(:taggings) }
  it { should have_many(:tags) } 
 
  context "setting tag list" do
    it "should be able to use two separate tags" do
      model = TaggableModel.new(name: "post")
      tag_names = "Sports, Food"
      model.tag_list = tag_names
      model.save

      expect(model.tags.count).to eq(2)
    end 

    it "should create a context tag with colon" do
      model = TaggableModel.new(name: "post") 
      tag_names = "Sports:Lacrosse"
      model.tag_list = tag_names
      model.save

      expect(HasTags::Tag.last.context.name).to eq("Sports")
    end

    it "should support multiple nested contexts" do
      model = TaggableModel.new(name: "post") 
      tag_names = "Sports:Lacrosse:Plays"
      model.tag_list = tag_names
      model.save

      expect(HasTags::Tag.last.context.name).to eq("Lacrosse")
    end
  end

  it "should retrieve tag list" do
    model = TaggableModel.new(name: "post") 
    tag_names = "Sports:Lacrosse"
    model.tag_list = tag_names
    model.save

    expect(model.tag_list).to eq("Sports, Lacrosse")
  end
end
