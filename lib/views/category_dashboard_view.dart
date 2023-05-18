import 'package:daily_basket_sellers/blocs/category_bloc.dart';
import 'package:daily_basket_sellers/views/add_edit_category_view.dart';
import 'package:flutter/material.dart';

class CategoryDashboardView extends StatefulWidget {
  @override
  _CategoryDashboardViewState createState() => _CategoryDashboardViewState();
}

class _CategoryDashboardViewState extends State<CategoryDashboardView> {
  CategoryBloc _categoryBloc = CategoryBloc();

  var enableConfirmationMessage =
      'This will activate category and will make it available for customers to place orders.';
  var disableConfirmationMessage =
      'This will hide category and product associated with this category from customer. This will also hide products of this category from customer\'s cart.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryFormView(null)),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: _categoryBloc.getCategories,
              builder: (context, snapshot) {
                return Container(
                  // height: 145,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Total Categories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            Center(
                                child: Text(
                              snapshot.hasData ? '${snapshot.data.length}' : '0',
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: _categoryBloc.getCategories,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // (snapshot.data[0]);
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryFormView(
                                                  snapshot.data[index])));
                                },
                                leading: Image.network(
                                    snapshot.data[index]['image']['url']),
                                title: Text(snapshot.data[index]['name']),
                                subtitle: Text(
                                    'Last modified: ${snapshot.data[index]['updated_at'].split('T')[0]}'),
                                trailing: PopupMenuButton(
                                  onSelected: (result) {
                                    if (result == 'enable' ||
                                        result == 'disable') {
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            title: Text(
                                              'Are you sure?',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            content: Text(result == 'enable'
                                                ? enableConfirmationMessage
                                                : disableConfirmationMessage),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 0.7),
                                                  )),
                                              FlatButton(
                                                onPressed: () async {
                                                  await _categoryBloc
                                                      .updateCategoryStatus(
                                                          snapshot.data[index]
                                                              ['id'],
                                                          result == 'enable'
                                                              ? 1
                                                              : 2);
                                                  _categoryBloc
                                                      .getCategoryList();
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  result == 'enable'
                                                      ? 'Activate'
                                                      : 'Deactivate',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0.7),
                                                ),
                                              ),
                                            ],
                                          ));
                                    } else if (result == 'delete') {
                                      if (snapshot.data[index]['status'] == 1) {
                                        showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              title: Text(
                                                'Warning!',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              content: Text(
                                                  'This category is active and available to customer for orders. Please deactivate category first to proceed.'),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Okay',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: 0.7),
                                                    )),
                                              ],
                                            ));
                                      } else {
                                        showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              title: Text(
                                                'Are you sure?',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              content: Text(
                                                  'Deleting category will hide the products associated with it and will no longer be available to order.'),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: 0.7),
                                                    )),
                                                FlatButton(
                                                  onPressed: () async {
                                                    await _categoryBloc
                                                        .deleteCategory(snapshot
                                                            .data[index]['id']);
                                                    _categoryBloc
                                                        .getCategoryList();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 0.7),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      }
                                    } else {}
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem(
                                        value:
                                            snapshot.data[index]['status'] == 1
                                                ? 'disable'
                                                : 'enable',
                                        child: Text(
                                            snapshot.data[index]['status'] == 1
                                                ? 'Deactivate'
                                                : 'Activate'),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Delete'),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
