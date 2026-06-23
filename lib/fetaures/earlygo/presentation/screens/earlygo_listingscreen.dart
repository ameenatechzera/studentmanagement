import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/entities/fetch_earlygorequest_entity.dart';
import 'package:studentmanagement/fetaures/earlygo/presentation/cubit/earlygo_cubit.dart';
import 'package:studentmanagement/fetaures/earlygo/presentation/screens/earlygo_requestscreen.dart';

class EarlyGoScreen extends StatefulWidget {
  const EarlyGoScreen({super.key});

  @override
  State<EarlyGoScreen> createState() => _EarlyGoScreenState();
}

class _EarlyGoScreenState extends State<EarlyGoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EarlygoCubit>().fetchEarlyLeave();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Early Go Request",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xffE2E1FF),
              child: SvgPicture.asset('assets/icons/Group (4).svg'),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff807FD8),
          shape: const CircleBorder(),
          elevation: 6,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return EarlyGoRequestScreen();
                },
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),

      body: BlocBuilder<EarlygoCubit, EarlygoState>(
        builder: (context, state) {
          if (state is EarlyLeaveLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EarlyLeaveError) {
            return Center(child: Text(state.message));
          }
          if (state is EarlyLeaveLoaded) {
            final requests = state.response.data ?? [];

            if (requests.isEmpty) {
              return const Center(child: Text("No Early Leave Requests"));
            }
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              itemCount: requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return EarlyGoCard(request: requests[index]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class EarlyGoCard extends StatelessWidget {
  final EarlyLeaveDetails request;

  const EarlyGoCard({super.key, required this.request});

  Color get statusColor {
    switch ((request.finalStatus ?? '').toLowerCase()) {
      case 'approved':
        return const Color(0xff00CD35);

      case 'rejected':
        return const Color(0xffD21B00);

      default:
        return const Color(0xffEFEEFF);
    }
  }

  Color get textColor {
    switch ((request.finalStatus ?? '').toLowerCase()) {
      case 'pending':
        return Colors.black54;

      default:
        return Colors.white;
    }
  }

  IconData get statusIcon {
    switch ((request.finalStatus ?? '').toLowerCase()) {
      case 'approved':
        return Icons.check;

      case 'rejected':
        return Icons.close;

      default:
        return Icons.access_time;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('earlyLeaveDate => ${request.earlyLeaveDate}');
    print('requestDate => ${request.requestDate}');
    String date = '';
    String day = '';

    try {
      if (request.earlyLeaveDate != null) {
        final parsedDate = DateTime.parse(request.earlyLeaveDate!);

        date = DateFormat('dd-MM-yyyy').format(parsedDate);
        day = DateFormat('EEEE').format(parsedDate);
      }
    } catch (e) {
      print('Date Parse Error => $e');
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xff807FD8),
                child: SvgPicture.asset('assets/icons/Group (3).svg'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Request for Half Day',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: textColor, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      request.finalStatus ?? 'Pending',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(children: [_chip(date), const SizedBox(width: 8), _chip(day)]),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xffEFF4FF),
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                left: BorderSide(color: Color(0xff006A61), width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "REASON",
                  style: TextStyle(
                    color: Color(0xff009688),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  request.reason ?? '',
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xff807FD8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
