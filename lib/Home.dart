import 'package:flutter/material.dart';
import 'package:random_userdata/http_services.dart';
import 'package:random_userdata/apiUtil.dart';

import '../user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpService httpService = HttpService();

  @override
  void initState() {
    httpService.getMultipleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Data"),
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Result>>(
                  future: httpService.getMultipleData(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      List<Result> data = snapShot.data!;
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: const Color(0xff777777))
                                      ),
                                      child: ExpansionTile(
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                "${data[index].picture!.large}"),
                                          ),
                                          backgroundColor: Colors.white,
                                          tilePadding: const EdgeInsets.all(8),
                                          title: Text(
                                            "${data[index].name!.title} ${data[index].name!.first}${data[index].name!.last}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "${data[index].email}",
                                          ),
                                          expandedAlignment: Alignment.centerLeft,
                                          childrenPadding:
                                          const EdgeInsets.all(15),
                                          expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const Text("User Data",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                                            Text(
                                                "Phone No : ${data[index].phone} / ${data[index].cell}"),
                                            Text(
                                                "Gender : ${data[index].gender}"),
                                            Text(
                                                "DOB : ${data[index].dob!.date}"),
                                            Text("Age : ${data[index].dob!.age}"),
                                            Text(
                                                "Nationality : ${data[index].nat}"),
                                            Row(
                                              children: [
                                                const Text("Location :: "),
                                                Expanded(
                                                  child: Text(
                                                      "${data[index].location!.street!.number},${data[index].location!.street!.name}, "
                                                          "${data[index].location!.city},${data[index].location!.state},"
                                                          "${data[index].location!.country},${data[index].location!.postcode}, "),
                                                )
                                              ],
                                            )
                                          ]),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white70,
    );
  }
}