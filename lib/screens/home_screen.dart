import 'package:flutter/material.dart';
import 'package:flutter_shimmer_effect/data/movie_data.dart';
import 'package:flutter_shimmer_effect/models/movie_model.dart';
import 'package:flutter_shimmer_effect/widgets/custom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieModel> list = [];
  bool isLoading = false;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    list = List.of(allMovies);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(icon: Icon(Icons.refresh), onPressed: loadData)],
        ),
        body: ListView.builder(
            itemCount: isLoading ? 5 : list.length,
            itemBuilder: (BuildContext context, int index) {
              if (isLoading) {
                return CustomShimmer();
              } else {
                return CustomListItem(list[index]);
              }
            }));
  }

  Widget CustomShimmer() {
    return ListTile(
      leading: CustomWidget.circular(height: 64, width: 64),
      title: Align(
        alignment: Alignment.centerLeft,
        child: CustomWidget.rectangular(
          height: 16,
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ),
      subtitle: CustomWidget.rectangular(height: 14),
    );
  }

  Widget CustomListItem(MovieModel model) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(model.urlImg),
      ),
      title: Text(
        model.title,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        model.detail,
        style: TextStyle(fontSize: 14),
        maxLines: 1,
      ),
    );
  }
}
