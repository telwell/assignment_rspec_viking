require 'viking'

describe 'viking' do
	let(:v){Viking.new("Trevor")}
	let(:other_viking){Viking.new("Other Viking")}

	it 'passing a name sets the name attribute' do
		v_test = Viking.new(name="Trevor")
		expect(v_test.name).to eq("Trevor")
	end

	it 'passing a health attr sets health' do
		v_test = Viking.new("Trevor",90)
		expect(v_test.health).to eq(90)
	end

	it 'cannot override health once it has been set' do
		expect{v.health=(10)}.to raise_error
	end

	it 'has no weapon by default' do
		expect(v.weapon).to be_nil
	end

	it 'can pick up a weapon' do
		v.pick_up_weapon(Bow.new)
		expect(v.weapon.name).to eq("Bow")
	end

	it 'cannot pick up a non-weapon' do
		expect{v.pick_up_weapon(Mace.new)}.to raise_error
	end

	it 'picking up a new weapon replaces the old weapon' do
		v.pick_up_weapon(Bow.new)
		v.pick_up_weapon(Axe.new)
		expect(v.weapon.name).to eq("Axe")
	end

	it 'can drop a weapon' do
		v.pick_up_weapon(Bow.new)
		v.drop_weapon
		expect(v.weapon).to be_nil
	end

	it 'can receive an attack' do
		v.receive_attack(50)
		expect(v.health).to eq(50)
	end

	it 'receive_attack calls take_damage method' do
		expect(v).to receive(:take_damage)
		v.receive_attack(20)
	end

	it 'attacking another viking causes the receipiant\'s health to drop' do
		start_health = other_viking.health
		v.attack(other_viking)
		end_health = other_viking.health
		expect(start_health).to be > end_health
	end

	it 'attacking another viking calls it\s take_damage method' do
		expect(other_viking).to receive(:take_damage)
		v.attack(other_viking)
	end

	it 'attacking with no weapon calls damage_with_fists' do
		expect(:damage_with_fists)
		v.attack(other_viking)
	end

	it 'attacking with fists deals the right amount of damage' do
		expect(other_viking).to receive(:take_damage).with(v.strength * 0.25)
		v.attack(other_viking)
	end

	it 'attacking with a weapon calls damage_with_weapon' do
		v.pick_up_weapon(Bow.new)
		expect(:damage_with_weapon)
		v.attack(other_viking)
	end

	it 'attacking with a weapon deals damage of strength * multiplier' do
		v.pick_up_weapon(Bow.new)
		# I'm able to use v.weapon.use here because the use method
		# simply returns the multiplier. Multiplier itself isn't readable.
		expect(other_viking).to receive(:take_damage).with(v.strength * v.weapon.use)
		v.attack(other_viking)
	end

	it 'attacking with no arrows calls damage_with_fists instead' do
		v.pick_up_weapon(Bow.new(1))
		v.attack(other_viking)
		expect(:damage_with_fists)
		v.attack(other_viking)
	end

	it 'killing a viking raises an error' do
		expect{v.receive_attack(150)}.to raise_error
	end

end