import 'package:daily_basket_sellers/blocs/product_bloc.dart';
import 'package:daily_basket_sellers/components/product_form_component.dart';
import 'package:daily_basket_sellers/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/Image_view_component.dart';
import 'package:daily_basket_sellers/blocs/category_bloc.dart';

class AddEditProductView extends StatefulWidget {
  final product;

  AddEditProductView(this.product);
  @override
  _AddEditProductViewState createState() =>
      _AddEditProductViewState(this.product);
}

class _AddEditProductViewState extends State<AddEditProductView> {
  var _product;
  var dropdownValue = 'Kg';
  String selectedCategory;
  String name;
  String description;
  String productImage;
  num price;
  int quantity;
  int baseQuantity;
  String unit;
  int categoryId;
  ProductBloc _productBloc = ProductBloc();
  CategoryBloc _categoryBloc = CategoryBloc();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  _AddEditProductViewState(this._product);

  @override
  void initState() {
    selectedCategory =
        _product != null ? _product['category_id'].toString() : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: (30 *
                                  ((MediaQuery.of(context).size.height - 30) -
                                      Scaffold.of(context).appBarMaxHeight)) /
                              100,
                          width: (95 * MediaQuery.of(context).size.width) / 100,
                          child: ImageView(
                            image: _product != null
                                ? _product['image']['url']
                                : null,
                            validator: (image) {
                              // ('Validator => ${image == null}');
                              if (image == null) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Image required')));
                                return 'Image required';
                              }
                              productImage = image;
                              return null;
                            },
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // height: 250,
                          width: (95 * MediaQuery.of(context).size.width) / 100,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text('Category'),
                                      SizedBox(width: 10),
                                      StreamBuilder(
                                          stream: _categoryBloc.getCategories,
                                          builder: (context, snapshot) {
                                            var categories = snapshot.hasData
                                                ? snapshot.data
                                                : [];
                                            return DropdownButton(
                                                value: selectedCategory,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    selectedCategory = value;
                                                  });
                                                },
                                                items: categories.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (eachCategory) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value:
                                                        '${eachCategory['id']}',
                                                    child: Text(
                                                      eachCategory['name'],
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  );
                                                }).toList());
                                          }),
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Name *',
                                  ),
                                  initialValue: _product != null
                                      ? _product['name']
                                      : null,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Name is required";
                                    }

                                    if (value.length < 3) {
                                      return "Name must have at least 3 characters";
                                    }
                                    name = value;
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  initialValue: _product != null
                                      ? _product['description']
                                      : null,
                                  validator: (value) {
                                    if (value != '' && value.length < 3) {
                                      return "Description must have at least 3 characters";
                                    }
                                    description = value;
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Base quantity*',
                                    ),
                                    initialValue: _product != null
                                        ? '${_product['base_quantity']}'
                                        : '1',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Base quantity is required";
                                      }

                                      if (int.parse(value) < 1) {
                                        return "Base quantity must be atleast 1";
                                      }
                                      baseQuantity = int.parse(value);
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text('Unit'),
                                        SizedBox(width: 10),
                                        DropdownButton(
                                            value: dropdownValue,
                                            items: [
                                              'Kg',
                                              'Dozens',
                                              'Litre',
                                              'Grams'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (abc) async {
                                              setState(() {
                                                dropdownValue = abc;
                                              });
                                            }),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Price*',
                                      prefix: Text('₹'),
                                    ),
                                    initialValue: _product != null
                                        ? '${_product['price']}'
                                        : '1.00',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Price is required";
                                      }

                                      if (num.parse(value) < 1) {
                                        return "Price must be atleast 1";
                                      }
                                      price = num.parse(value);
                                      return null;
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp(r'^(\d+)?\.?\d{0,2}')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Quantity (in stock)*',
                                  ),
                                  initialValue: _product != null
                                      ? '${_product['quantity']}'
                                      : '1',
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Quantity is required";
                                    }

                                    if (int.parse(value) < 1) {
                                      return "Quantity must be atleast 1";
                                    }
                                    quantity = int.parse(value);
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Please wait')));
                        if (_product == null) {
                          var response = await _productBloc.addProduct(
                              int.parse(selectedCategory),
                              name,
                              description,
                              baseQuantity,
                              dropdownValue.toLowerCase(),
                              price,
                              quantity,
                              productImage);
                          if (response.statusCode == 200) {
                            _productBloc.getProductsList(1, 15, 'created_at', 'desc', true);
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text('Saved')));
                            Navigator.pop(context);
                          }
                        } else {
                          // existing product
                          var response = await _productBloc.updateProduct(
                              _product['id'],
                              int.parse(selectedCategory),
                              name,
                              description,
                              baseQuantity,
                              dropdownValue.toLowerCase(),
                              price,
                              quantity,
                              productImage);
                          if (response.statusCode == 200) {
                            _productBloc.getProductsList(1, 15, 'created_at', 'desc', true);
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text('Saved')));
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: (50 * MediaQuery.of(context).size.width) / 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      )),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
