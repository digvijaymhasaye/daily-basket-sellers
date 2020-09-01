import 'package:daily_basket_sellers/models/category_request_model.dart';
import 'package:flutter/material.dart';

import 'Image_view_component.dart';

class CategoryFormComponent extends StatefulWidget {
  final categoryData;
  CategoryFormComponent(this.categoryData);

  @override
  _CategoryFormComponentState createState() =>
      _CategoryFormComponentState(this.categoryData);
}

class _CategoryFormComponentState extends State<CategoryFormComponent> {
  var _categoryData;

  CategoryRequestModel _categoryRequestModel;

  _CategoryFormComponentState(this._categoryData);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
          padding: EdgeInsets.all(10.0),
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
            image: _categoryData != null ? _categoryData['image']['url'] : null,
            validator: (image) {
              if (image == null) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Image required')));
                return 'Image required';
              }
              CategoryRequestModel.image = image;
              return null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: (60 *
                  ((MediaQuery.of(context).size.height - 30) -
                      Scaffold.of(context).appBarMaxHeight)) /
              100,
          width: (95 * MediaQuery.of(context).size.width) / 100,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Name *',
                  ),
                  initialValue:
                      _categoryData != null ? _categoryData['name'] : null,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Name is required";
                    }

                    if (value.length < 3) {
                      return "Name must have at least 3 characters";
                    }
                    CategoryRequestModel.name = value;
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
                  initialValue:
                      _categoryData != null ? _categoryData['description'] : null,
                  validator: (value) {
                    if (value != '' && value.length < 3) {
                      return "Description must have at least 3 characters";
                    }
                    CategoryRequestModel.description = value;
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
