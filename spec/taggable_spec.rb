require 'spec_helper'

describe TaggableModel do
  #let (:model) { TaggableModel.create(name: "post") }
 
  it { should have_many(:taggings) }
  it { should have_many(:tags) } 
end
