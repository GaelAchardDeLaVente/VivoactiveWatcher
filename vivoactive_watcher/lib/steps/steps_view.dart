import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:steps_api/steps_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../presentation/loading_indicator.dart';
import 'blocs/steps_bloc.dart';

class StepsView extends StatefulWidget {
  const StepsView({Key? key}) : super(key: key);

  @override
  State<StepsView> createState() => _StepsViewState();
}

class _StepsViewState extends State<StepsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepsBloc, StepsState>(
      builder: (context, state) {
        if (state is StepsLoading) {
          return LoadingIndicator();
        }
        if (state is StepsLoaded) {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      labelStyle: GoogleFonts.poppins(),
                    ),
                    series: <ColumnSeries<StepData, String>>[
                      ColumnSeries<StepData, String>(
                        animationDelay: 2,
                        animationDuration: 6,
                        color: Colors.blue,
                        spacing: 0.3,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        dataSource: state.steps,
                        xValueMapper: (StepData step, _) =>
                            DateFormat("E", 'fr')
                                .format(step.date)
                                .capitalize(),
                        yValueMapper: (StepData step, _) => step.stepsNumber,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.steps.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat("EEEE dd MMMM", 'fr')
                                          .format(
                                              state.steps.elementAt(index).date)
                                          .capitalize(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                          fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '${state.steps.elementAt(index).stepsNumber} pas',
                                        style: GoogleFonts.lexend(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 48),
                            child: Divider(),
                          );
                        },
                      ),
                    )
                  ],
                ),
                flex: 2,
              )
            ],
          );
        } else {
          return Center(
            child: Text("Erreur state = $state"),
          );
        }
      },
    );
  }
}

class WalkDay {
  WalkDay(this.day, this.step);
  final String day;
  final double step;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
