require 'weapons/bow'

describe 'bow' do
	let(:bow){Bow.new}
	it 'can read the number of arrows' do
		expect(bow.arrows).to be_a(Fixnum)
	end

	it 'starts with 10 arrows' do
		expect(bow.arrows).to eq(10)
	end

	it 'can take a specific number of arrows' do
		new_bow = Bow.new(2)
		expect(new_bow.arrows).to eq(2)
	end

	it 'using the bow reduces arrow count by 1' do
		expect{bow.use}.to change{bow.arrows}.by(-1)
	end

	it 'throws error with an empty bow' do
		empty_bow = Bow.new(0)
		expect{empty_bow.use}.to raise_error
	end
end