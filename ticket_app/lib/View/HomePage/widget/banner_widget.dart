

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/ViewModel/BloC/banner_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/my_event.dart';
import 'package:ticket_app/ViewModel/service.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

  int indexBanner = 0;
  int lengthbanner = 3;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<BannerBloc>(context);
    bloc.event.add(FetchBanner());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(

        fit: StackFit.expand,
        children: [
            Consumer<BannerBloc>(
              builder: (context, bloc, child) => StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  if(!snapshot.hasData || snapshot.data!.isEmpty){
                    return const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case ConnectionState.active:
                      return  CarouselSlider.builder(
                                  itemCount: snapshot.data!.length,
                                  options: CarouselOptions(
                                  initialPage: indexBanner,
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  onPageChanged: (index, reason){
                                    setState(() {
                                    indexBanner = index;
                                    });
                                  }
                                  ),
                                  itemBuilder: ( context,  index, int realIndex) {
                                  lengthbanner = snapshot.data!.length;
                                  return Container(
                                      decoration: BoxDecoration(
                                      //borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                      image: NetworkImage('${ServiceRepository.baseURL}${snapshot.data![index].imageasset.toString()}'

                                  ),
                                  fit: BoxFit.cover,

                                  )
                                  ),
                                  //child: Image(image: AssetImage(listBanner[index]), fit: BoxFit.cover,)
                                  );
                                  },
                              );
                    default:
                      return const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                  }
                }
              ),
            ),

           Positioned(
              left: 16,
              bottom: 16,
              child: Row(
                children:
                  List.generate(
                      lengthbanner,
                      (index){
                        return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                          width: indexBanner == index ? 24 : 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: indexBanner == index ? Colors.deepOrangeAccent : Colors.grey,
                            borderRadius: BorderRadius.circular(50)
                          ),
                        );

                      }
                  )


              )
          )
        ]
      ),
    );
  }
}

