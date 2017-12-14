require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @update = {
      title: 'Lorem Ipsum',
      description: 'Wibbles are fun!',
      image_url: 'lorem.jpg',
      price: 19.95
    }
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: @update }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: @update }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "link hrefs should not be empty for actions" do 
    get :index
    assert_select "td.list_actions a" do
      assert_select "[href=?]", /.+/  # Not empty
    end
  end  

  test "should get products index" do
    get :index
    assert_response :success
    assert_select '.products .list_description', minimum: 3
    assert_select '.products .list_description dl dt', 'Programming Ruby 1.9'
    assert_select '.products .list_description dl dd', /.{1,80}/
    assert_select '.products .list_actions', minimum: 3
    ['Show', 'Edit', 'Destroy'].each do |action|
      assert_select '.products .list_actions a', action
    end
    assert_select 'a', 'New Product'
  end

  test "can't delete product in cart" do
    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    end
    assert_redirected_to products_url 
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end
    assert_redirected_to products_url
  end
end
