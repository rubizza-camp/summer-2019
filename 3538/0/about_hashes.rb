require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = {}
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { one: 'uno', two: 'dos' }
    assert_equal 'uno', hash[:one]
    assert_equal 'dos', hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { one: 'uno' }
    assert_equal 'uno', hash.fetch(:one)
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
  end

  def test_changing_hashes
    hash = { one: 'uno', two: 'dos' }
    hash[:one] = 'eins'

    expected = { one: 'eins', two: 'dos' }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  def test_hash_is_unordered
    hash_1 = { one: 'uno', two: 'dos' }
    hash_2 = { two: 'dos', one: 'uno' }

    assert_equal true, hash_1 == hash_2
  end

  def test_hash_keys
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class
  end

  def test_hash_values
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?('uno')
    assert_equal true, hash.values.include?('dos')
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { 'jim' => 53, 'amy' => 20, 'dan' => 23 }
    new_hash = hash.merge('jim' => 54, 'jenny' => 26)

    assert_equal true, hash != new_hash

    expected = { 'jim' => 54, 'amy' => 20, 'dan' => 23, 'jenny' => 26 }
    assert_equal true, expected == new_hash
  end

  def test_default_value
    hash_1 = {}
    hash_1[:one] = 1

    assert_equal 1, hash_1[:one]
    assert_equal nil, hash_1[:two]

    hash_2 = Hash.new('dos')
    hash_2[:one] = 1

    assert_equal 1, hash_2[:one]
    assert_equal 'dos', hash_2[:two]
  end

  def test_default_value_is_the_same_object
    hh = Hash.new([])

    hh[:one] << 'uno'
    hh[:two] << 'dos'

    assert_equal %w[uno dos], hh[:one]
    assert_equal %w[uno dos], hh[:two]
    assert_equal %w[uno dos], hh[:three]

    assert_equal true, hh[:one].object_id == hh[:two].object_id
  end

  def test_default_value_with_block
    new_hash = Hash.new { |hash, key| hash[key] = [] }

    new_hash[:one] << 'uno'
    new_hash[:two] << 'dos'

    assert_equal ['uno'], new_hash[:one]
    assert_equal ['dos'], new_hash[:two]
    assert_equal [], new_hash[:three]
  end
end
