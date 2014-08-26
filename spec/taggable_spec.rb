require 'spec_helper'

describe TaggableModel do
  let (:model) { TaggableModel.create(name: "post") }
 
  it { should have_many(:taggings) }
  it { should have_many(:tags) } 
 
  context "setting tag list" do
    it "should be able to use two separate tags" do
      tag_names = "Sports, Food"
      model.tag_list = tag_names

      expect(model.tags.count).to eq(2)
    end 

    it "should create a context tag with colon" do
      tag_names = "Sports:Lacrosse"
      model.tag_list = tag_names

      expect(HasTags::Tag.last.context.name).to eq("Sports")
    end
    
    it "should support multiple nested contexts" do
      tag_names = "Sports:Lacrosse:Plays"
      model.tag_list = tag_names

      expect(HasTags::Tag.last.context.name).to eq("Lacrosse")
    end
  end

  it "should retrieve tag list" do
    tag_names = "Sports:Lacrosse"
    model.tag_list = tag_names

    expect(model.tag_list).to eq("Sports, Lacrosse")
  end
end
