require "rails_helper"


describe ProjectDecorator do
  let(:project) { instance_double(Project) }
  let(:decorator) { ProjectDecorator.new(project) }

  before do
    allow(project).to receive(:id).and_return(1)
  end

  describe "#href" do
    let(:href) { decorator.href}
    it "returns a url to the project" do
      expect(href).to eq("/projects/#{project.id}")
    end
  end
end
