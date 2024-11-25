import 'package:flutter/material.dart';
import 'package:personagem_list/components/strength_status.dart';

class PersonagemCard extends StatefulWidget {
  final String name;
  final String race;
  final int strength;
  final String url;

  PersonagemCard(this.name, this.race, this.strength, this.url, {super.key});

  int lifePoint = 100;

  @override
  State<PersonagemCard> createState() => _PersonagemCardState();
}

class _PersonagemCardState extends State<PersonagemCard> {

  bool assetOrNetwork (){
    if(widget.url.contains("http")){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)),
              height: 170,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 120,
                            color: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: assetOrNetwork() ? Image.asset(widget.url,
                                fit: BoxFit.cover,
                              ) : Image.network(widget.url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                Text(widget.race, style: const TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.w400),),
                                StrengthBar(strengthstatus: widget.strength)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.center
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      widget.lifePoint++;
                                      if(widget.lifePoint > 100){
                                        widget.lifePoint = 100;
                                      }
                                    });
                                  }, child: const Icon(Icons.arrow_drop_up)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.center
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      widget.lifePoint --;
                                      if(widget.lifePoint < 0){
                                        widget.lifePoint = 0;
                                      }
                                    });
                                  }, child: const Icon(Icons.arrow_drop_down)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 250,
                          child: LinearProgressIndicator( color: Colors.orange, value: widget.lifePoint/100,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Vida: ${widget.lifePoint}",
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
