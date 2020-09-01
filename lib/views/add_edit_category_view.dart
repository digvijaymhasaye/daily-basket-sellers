import 'package:daily_basket_sellers/blocs/category_bloc.dart';
import 'package:daily_basket_sellers/blocs/image_bloc.dart';
import 'package:daily_basket_sellers/models/category_request_model.dart';
import 'package:daily_basket_sellers/views/category_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:daily_basket_sellers/components/category_form_component.dart';

class CategoryFormView extends StatefulWidget {
  final category;
  CategoryFormView(this.category);

  @override
  _CategoryFormViewState createState() => _CategoryFormViewState(this.category);
}

class _CategoryFormViewState extends State<CategoryFormView> {
  var _category;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CategoryBloc _categoryBloc = CategoryBloc();

  _CategoryFormViewState(this._category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(_category == null ? 'Add Category' : 'Edit Category'),
      ),
      body: ListView(
        children: <Widget>[
          Form(key: _formKey, child: CategoryFormComponent(_category)),
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Please wait')));
                    if (_category == null) {
                      // New category
                      var response = await _categoryBloc.addCategory(
                          CategoryRequestModel.name,
                          CategoryRequestModel.description,
                          CategoryRequestModel.image);
                      if (response.statusCode == 200) {
                        _categoryBloc.getCategoryList();
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Saved')));
                        Navigator.pop(context);
                      }
                    } else {
                      // existing category
                      var response = await _categoryBloc.updateCategory(
                          _category['id'],
                          CategoryRequestModel.name,
                          CategoryRequestModel.description,
                          CategoryRequestModel.image);
                      if (response.statusCode == 200) {
                        _categoryBloc.getCategoryList();
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
      ),
    );
  }
}
