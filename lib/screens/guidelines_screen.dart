import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/widgets/back_icon_btn.dart';
import 'package:covid_tracker/widgets/cards/gradient_card.dart';
import 'package:covid_tracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class GuidelinesScreen extends StatelessWidget {
  static const routeName = 'guidelines-screen';

  @override
  Widget build(BuildContext context) {
    final double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    final double bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: GUIDELINES,
              titleColor: Theme.of(context).accentColor,
              leading: BackIconBtn(),
            ),
            Expanded(child: _buildBody(bodyWidth, bodyHeight))
          ],
        ),
      ),
    );
  }

  Widget _buildBody(double width, double height) => ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Text(
                  ("Protecting yourself and others from "
                          "the spread COVID-19\n")
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "You can reduce your chances of being "
                  "infected or spreading COVID-19 by "
                  "taking some simple precautions:",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          GradientCard(
              text: "Regularly and thoroughly clean your hands "
                  "with an alcohol-based hand rub or wash them "
                  "with soap and water. Why? Washing your hands "
                  "with soap and water or using alcohol-based hand"
                  " rub kills viruses that may be on your hands."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Maintain at least 1 metre (3 feet) distance"
                  " between yourself and others. Why? When someone"
                  " coughs, sneezes, or speaks they spray small "
                  "liquid droplets from their nose or mouth which "
                  "may contain virus. If you are too close, you "
                  "can breathe in the droplets, including the "
                  "COVID-19 virus if the person has the disease."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Avoid going to crowded places. Why? Where "
                  "people come together in crowds, you "
                  "are more likely to come into close "
                  "contact with someone that has COIVD-19 "
                  "and it is more difficult to maintain "
                  "physical distance of 1 metre (3 feet)."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Avoid touching eyes, nose and mouth. Why? "
                  "Hands touch many surfaces and can pick "
                  "up viruses. Once contaminated, hands "
                  "can transfer the virus to your eyes, "
                  "nose or mouth. From there, the virus "
                  "can enter your body and infect you."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Make sure you, and the people around you, "
                  "follow good respiratory hygiene. "
                  "This means covering your mouth and "
                  "nose with your bent elbow or tissue "
                  "when you cough or sneeze. Then dispose "
                  "of the used tissue immediately and wash "
                  "your hands. Why? Droplets spread virus."
                  " By following good respiratory hygiene, "
                  "you protect the people around you from "
                  "viruses such as cold, flu and COVID-19."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Make sure you, and the people around you, "
                  "follow good respiratory hygiene. "
                  "This means covering your mouth and nose "
                  "with your bent elbow or tissue when you "
                  "cough or sneeze. Then dispose of the used "
                  "tissue immediately and wash your hands. "
                  "Why? Droplets spread virus. By following"
                  " good respiratory hygiene, you protect "
                  "the people around you from viruses such "
                  "as cold, flu and COVID-19."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Stay home and self-isolate even with minor "
                  "symptoms such as cough, headache, mild "
                  "fever, until you recover. Have someone "
                  "bring you supplies. If you need to "
                  "leave your house, wear a mask to avoid "
                  "infecting others. Why? Avoiding contact "
                  "with others will protect them from"
                  " possible COVID-19 and other viruses."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "If you have a fever, cough and difficulty "
                  "breathing, seek medical attention, but "
                  "call by telephone in advance if possible "
                  "and follow the directions of your local "
                  "health authority. Why? National and local "
                  "authorities will have the most up to date "
                  "information on the situation in your area. "
                  "Calling in advance will allow your health "
                  "care provider to quickly direct you to the "
                  "right health facility. This will also "
                  "protect you and help prevent spread of "
                  "viruses and other infections."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Keep up to date on the latest information "
                  "from trusted sources, such as WHO or your "
                  "local and national health authorities. "
                  "Why? Local and national authorities are "
                  "best placed to advise on what people in "
                  "your area should be doing to protect themselves."),
          const SizedBox(height: 10.0),
          Divider(),
          const SizedBox(height: 10.0),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    ("Advice on the safe use of alcohol-based "
                            "hand sanitizers\n")
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "To protect yourself and others against COVID-19,"
                    " clean your hands frequently and thoroughly. "
                    "Use alcohol-based hand sanitizer or wash "
                    "your hands with soap and water. If you use "
                    "an alcohol-based hand sanitizer, make sure "
                    "you use and store it carefully.",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Keep alcohol-based hand sanitizers out of "
                  "children’s reach. Teach them how to "
                  "apply the sanitizer and monitor its use."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Apply a coin-sized amount on your hands. "
                  "There is no need to use a large "
                  "amount of the product."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Avoid touching your eyes, mouth and nose "
                  "immediately after using an alcohol-based "
                  "hand sanitizer, as it can cause irritation."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Hand sanitizers recommended to protect against "
                  "COVID-19 are alcohol-based and therefore "
                  "can be flammable. Do not use before handling "
                  "fire or cooking."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Under no circumstance, drink or let children "
                  "swallow an alcohol-based hand sanitizer. "
                  "It can be poisonous."),
          const SizedBox(height: 10.0),
          GradientCard(
              text: "Remember that washing your hands with soap "
                  "and water is also effective against COVID-19."),
          Text(
            "• • •",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 24.0,
            ),
          ),
        ],
      );
}
