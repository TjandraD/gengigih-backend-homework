require_relative '../../controllers/category_controller'

describe CategoryController do
    before(:each) do
        @controller = CategoryController.new
    end

    describe 'form' do
        context 'new category' do
            it 'should return new category form' do
                expected_result = ERB.new(File.read("./views/create_category.erb"))

                expect(@controller.new_category_form).to eq(expected_result.result)
            end
        end

        context 'edit category' do
            it 'should return edit category form' do
                category = double
                expected_result = ERB.new(File.read("./views/edit_category.erb"))

                allow(Category).to receive(:new).with([]).and_return(category)
                expect(category).to receive(:get_category)

                allow(category).to receive(:id)
                allow(category).to receive(:name)

                expect(@controller.edit_category_form([])).to eq(expected_result.result_with_hash(category: category))
            end
        end

        context 'details category' do
            it 'should return details category form' do
                category = double
                expected_result = ERB.new(File.read("./views/category_details.erb"))

                allow(Category).to receive(:new).with([]).and_return(category)
                expect(category).to receive(:get_category_with_items)

                allow(category).to receive(:id)
                allow(category).to receive(:name)
                allow(category).to receive(:items).and_return([])

                expect(@controller.category_details([])).to eq(expected_result.result_with_hash(category: category))
            end
        end
    end

    describe 'input' do
        context 'category' do
            it 'should call insert new category method' do
                stub_model = double

                allow(Category).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:insert_category)

                @controller.new_category([])
            end
        end
    end

    describe 'edit' do
        context 'category' do
            it 'should call edit category method' do
                stub_model = double

                allow(Category).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:update_category)

                @controller.edit_category([])
            end
        end
    end

    describe 'delete' do
        context 'category' do
            it 'should call delete category method' do
                stub_model = double

                allow(Category).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:delete)

                @controller.delete_category([])
            end
        end
    end
end