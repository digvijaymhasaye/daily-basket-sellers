import 'package:daily_basket_sellers/blocs/product_bloc.dart';
import 'package:daily_basket_sellers/views/add_edit_product_view.dart';
import 'package:flutter/material.dart';

class ProductDashboardView extends StatefulWidget {
  @override
  _ProductDashboardViewState createState() => _ProductDashboardViewState();
}

class _ProductDashboardViewState extends State<ProductDashboardView> {
  ProductBloc _productBloc = ProductBloc();

  var enableConfirmationMessage =
      'This will activate category and will make it available for customers to place orders.';
  var disableConfirmationMessage =
      'This will hide category and product associated with this category from customer. This will also hide products of this category from customer\'s cart.';


  int totalProducts = 0;
  int pageNo = 0;
  int pageSize = 15;
  List productList = [];
  bool isLoading = false;
  loadData() async {
    var _products = await _productBloc.getProductsList(
        pageNo += 1, pageSize, 'updated_at', 'desc', false);

    setState(() {
      if (_products.length > 0) {
        productList.addAll(_products);
        totalProducts -= productList.length;
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadData();
    _productBloc.getStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditProductView(null)),
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
                stream: _productBloc.getStatsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    totalProducts = snapshot.data['total_products'];
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        // height: 145,
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
                                'Active products',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              Center(
                                  child: Text(
                                snapshot.hasData
                                    ? '${snapshot.data['active_products']}'
                                    : '0',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // height: 145,
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
                                'Total products',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              Center(
                                  child: Text(
                                snapshot.hasData
                                    ? '${snapshot.data['total_products']}'
                                    : '0',
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Most active products',
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
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    if (totalProducts > 0) {
                      loadData();
                      // start loading data
                      setState(() {
                        isLoading = true;
                      });
                    }
                  }
                  return null;
                },
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddEditProductView(
                                            productList[index])));
                          },
                          leading: Image.network(
                              productList[index]['image']['url']),
                          title: Text(productList[index]['name']),
                          subtitle: Text(
                              'Last modified: ${productList[index]['updated_at'].split('T')[0]}'),
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
                                            // await _categoryBloc
                                            //     .updateCategoryStatus(
                                            //         productList[index]
                                            //             ['id'],
                                            //         result == 'enable'
                                            //             ? 1
                                            //             : 2);
                                            // _categoryBloc
                                            //     .getCategoryList();
                                            // Navigator.pop(context);
                                          },
                                          child: Text(
                                            result == 'enable'
                                                ? 'Activate'
                                                : 'Deactivate',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.7),
                                          ),
                                        ),
                                      ],
                                    ));
                              } else if (result == 'delete') {
                                if (productList[index]['status'] == 1) {
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text(
                                          'Warning!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
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
                                              fontWeight: FontWeight.w600),
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
                                              // await _categoryBloc
                                              //     .deleteCategory(snapshot
                                              //         .data[index]['id']);
                                              // _categoryBloc
                                              //     .getCategoryList();
                                              // Navigator.pop(context);
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
                                  value: productList[index]['status'] == 1
                                      ? 'disable'
                                      : 'enable',
                                  child: Text(
                                      productList[index]['status'] == 1
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
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
