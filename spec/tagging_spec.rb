require 'spec_helper'

describe HasTags::Tagging do
  let(:tag) { HasTags::Tag.create(name: "Sports") }
  let(:model) { TaggableModel.create(name: "Post") }

  it { should belong_to(:tag) }
  it { should belong_to(:taggable) }
  it { should belong_to(:tagger) }

  it "should create a tagging" do
    HasTags::Tagging.create(tag_id: tag.id, taggable_id: model.id, taggable_type: model.class.to_s)   
    expect(HasTags::Tagging.count).to eq(1)
  end

  it "should fail without tag_id" do
    HasTags::Tagging.create(taggable_id: model.id, taggable_type: model.class.to_s)
    expect(HasTags::Tagging.count).to eq(0) 
  end
end
