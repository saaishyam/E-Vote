import 'package:flutter/material.dart';

void main() {
  runApp(const CampusVote());
}

class CampusVote extends StatelessWidget {
  const CampusVote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusVote',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090A0C),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF5B8CFF),
          surface: Color(0xFF111318),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF111318),
          hintStyle: TextStyle(color: Color(0xFF666A73)),
          labelStyle: TextStyle(color: Color(0xFF8B909A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xFF24272E)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xFF24272E)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xFF5B8CFF)),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController rollController = TextEditingController();

  @override
  void dispose() {
    rollController.dispose();
    super.dispose();
  }

  void login() {
    final roll = rollController.text.trim();

    if (roll.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter your roll number'),
          backgroundColor: Color(0xFF1B1D22),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              const Brand(),

              const Spacer(),

              const Text(
                'Welcome.',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.5,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Enter your roll number to continue.',
                style: TextStyle(fontSize: 15, color: Color(0xFF858A94)),
              ),

              const SizedBox(height: 42),

              const SmallLabel(text: 'ROLL NUMBER'),

              const SizedBox(height: 10),

              TextField(
                controller: rollController,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(fontSize: 17, letterSpacing: 1),
                decoration: const InputDecoration(
                  hintText: '26UCS049',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                ),
                onSubmitted: (_) => login(),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B8CFF),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'CONTINUE  →',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminPortalScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Admin login',
                    style: TextStyle(color: Color(0xFF777C86), fontSize: 13),
                  ),
                ),
              ),

              const Spacer(),

              const Center(
                child: Text(
                  'DIGITAL COLLEGE ELECTIONS',
                  style: TextStyle(
                    color: Color(0xFF41444B),
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool speakerVoted = false;
  bool ttmVoted = false;

  void openElection({
    required String title,
    required String prefix,
    required bool alreadyVoted,
  }) {
    if (alreadyVoted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have already voted in this election.'),
          backgroundColor: Color(0xFF1B1D22),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VotingScreen(
          title: title,
          itemPrefix: prefix,
          onVoteSubmitted: () {
            setState(() {
              if (prefix == 'Speaker') {
                speakerVoted = true;
              } else {
                ttmVoted = true;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Brand(),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Color(0xFF70747D),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              const Align(
                alignment: Alignment.centerLeft,
                child: SmallLabel(text: 'ELECTIONS'),
              ),

              const SizedBox(height: 12),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose an election.',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'You can vote once in each election.',
                  style: TextStyle(color: Color(0xFF777C86), fontSize: 14),
                ),
              ),

              const SizedBox(height: 38),

              ElectionTile(
                number: '01',
                title: 'Speaker',
                subtitle: speakerVoted
                    ? 'VOTE SUBMITTED'
                    : 'Choose your Speaker',
                voted: speakerVoted,
                onTap: () {
                  openElection(
                    title: 'Speaker',
                    prefix: 'Speaker',
                    alreadyVoted: speakerVoted,
                  );
                },
              ),

              const SizedBox(height: 12),

              ElectionTile(
                number: '02',
                title: 'TTM Speakers',
                subtitle: ttmVoted
                    ? 'VOTE SUBMITTED'
                    : 'Choose your TTM Speaker',
                voted: ttmVoted,
                onTap: () {
                  openElection(
                    title: 'TTM Speakers',
                    prefix: 'TTM Speaker',
                    alreadyVoted: ttmVoted,
                  );
                },
              ),

              const Spacer(),

              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFF202329),
              ),

              const SizedBox(height: 18),

              Row(
                children: const [
                  Icon(
                    Icons.verified_user_outlined,
                    size: 17,
                    color: Color(0xFF555A63),
                  ),
                  SizedBox(width: 9),
                  Text(
                    'One roll number · One vote per election',
                    style: TextStyle(color: Color(0xFF555A63), fontSize: 11),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class ElectionTile extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final bool voted;
  final VoidCallback onTap;

  const ElectionTile({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.voted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF111318),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF24272E)),
          ),
          child: Row(
            children: [
              Text(
                number,
                style: const TextStyle(
                  color: Color(0xFF555A63),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: voted
                            ? const Color(0xFF6C9AFF)
                            : const Color(0xFF70747D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                voted ? Icons.check_circle_outline : Icons.arrow_forward,
                size: 19,
                color: voted
                    ? const Color(0xFF5B8CFF)
                    : const Color(0xFF555A63),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VotingScreen extends StatefulWidget {
  final String title;
  final String itemPrefix;
  final VoidCallback onVoteSubmitted;

  const VotingScreen({
    super.key,
    required this.title,
    required this.itemPrefix,
    required this.onVoteSubmitted,
  });

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  int? selectedOption;

  void confirmVote() {
    if (selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select an option first.'),
          backgroundColor: Color(0xFF1B1D22),
        ),
      );
      return;
    }

    final selectedName = '${widget.itemPrefix} ${selectedOption! + 1}';

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111318),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallLabel(text: 'CONFIRM VOTE'),

                const SizedBox(height: 12),

                const Text(
                  'Are you sure?',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 8),

                Text(
                  'Your vote will be recorded for $selectedName.',
                  style: const TextStyle(
                    color: Color(0xFF777C86),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);

                      widget.onVoteSubmitted();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VoteSuccessScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B8CFF),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'CONFIRM VOTE',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                    },
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Color(0xFF777C86),
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF858A94),
                    ),
                  ),

                  const Spacer(),

                  const Brand(),
                ],
              ),

              const SizedBox(height: 48),

              const Align(
                alignment: Alignment.centerLeft,
                child: SmallLabel(text: 'VOTING'),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select one option.',
                  style: TextStyle(color: Color(0xFF777C86), fontSize: 14),
                ),
              ),

              const SizedBox(height: 36),

              VoteOption(
                number: '01',
                name: '${widget.itemPrefix} 1',
                selected: selectedOption == 0,
                onTap: () {
                  setState(() {
                    selectedOption = 0;
                  });
                },
              ),

              VoteOption(
                number: '02',
                name: '${widget.itemPrefix} 2',
                selected: selectedOption == 1,
                onTap: () {
                  setState(() {
                    selectedOption = 1;
                  });
                },
              ),

              VoteOption(
                number: '03',
                name: '${widget.itemPrefix} 3',
                selected: selectedOption == 2,
                onTap: () {
                  setState(() {
                    selectedOption = 2;
                  });
                },
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: confirmVote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOption == null
                        ? const Color(0xFF24272E)
                        : const Color(0xFF5B8CFF),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SUBMIT VOTE  →',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class VoteOption extends StatelessWidget {
  final String number;
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const VoteOption({
    super.key,
    required this.number,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected
                    ? const Color(0xFF5B8CFF)
                    : const Color(0xFF24272E),
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                number,
                style: const TextStyle(
                  color: Color(0xFF555A63),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(width: 22),

              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? Colors.white : const Color(0xFFB8BBC2),
                  ),
                ),
              ),

              Container(
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? const Color(0xFF5B8CFF)
                        : const Color(0xFF555A63),
                    width: 2,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF5B8CFF),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VoteSuccessScreen extends StatelessWidget {
  const VoteSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              const Brand(),

              const Spacer(),

              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF5B8CFF)),
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF5B8CFF),
                  size: 30,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Vote submitted.',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.2,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Your vote has been securely recorded.',
                style: TextStyle(color: Color(0xFF777C86), fontSize: 15),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF30333A)),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    'BACK TO ELECTIONS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminPortalScreen extends StatelessWidget {
  const AdminPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SmallLabel(text: 'ADMIN'),

            const SizedBox(height: 14),

            const Text(
              'Admin Portal',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Admin management will be available here.',
              style: TextStyle(color: Color(0xFF777C86), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class Brand extends StatelessWidget {
  const Brand({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF5B8CFF),
          ),
        ),

        const SizedBox(width: 9),

        const Text(
          'CAMPUSVOTE',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: Color(0xFFB8BBC2),
          ),
        ),
      ],
    );
  }
}

class SmallLabel extends StatelessWidget {
  final String text;

  const SmallLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF5B8CFF),
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.8,
      ),
    );
  }
}
