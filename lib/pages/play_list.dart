import 'package:flutter/material.dart';
import 'package:music_app/utils/constants/colors.dart';

class PlayListPage extends StatelessWidget {
  const PlayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: (){},child: const Icon(Icons.add,color: Colors.white,size: 30,),),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_,index){
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: kPrimaryColor,
                  ),
                  title: Text('Ed Sheeren',style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: kPrimaryColor
                ),),
                  subtitle: Text('Ed Sheeren',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios,color: kGreyColor,),
                );
              }))

        ],
      ),
    );
  }
}
