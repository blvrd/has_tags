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

  it "should retrieve all top level tags for class" do
    model = TaggableModel.new(name: "post") 
    tag_names = "Sports:Lacrosse"
    model.tag_list = tag_names
    model.save
    tag = model.tags.first
    
    expect(TaggableModel.top_level_tags).to include(tag)
  end

  context "TaggableModel.tagged_with" do
    it "should return all intances of it's class that are tagged with a specific tag" do
      model = TaggableModel.new(name: "post") 
      tag_names = "Sports:Lacrosse"
      model.tag_list = tag_names
      model.save

      expect(TaggableModel.tagged_with("Sports")).to include(model)
    end

    it "should return tag with similar title" do
      model = TaggableModel.new(name: "post") 
      tag_names = "Sports:Lacrosse"
      model.tag_list = tag_names
      model.save

      expect(TaggableModel.tagged_with("spots")).to include(model) 
    end

    it "should accept multiple tags to search by" do
      model = TaggableModel.new(name: "post") 
      tag_names = "Sports:Lacrosse"
      model.tag_list = tag_names
      model.save
      
      expect(TaggableModel.tagged_with("sports", "lacrosse")).to include(model)
    end
  end
end
