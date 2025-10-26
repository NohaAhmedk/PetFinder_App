import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder/core/networking/api_constants.dart';
import 'package:pet_finder/features/view_pets/data/datasources/pet_service.dart';
import 'package:pet_finder/features/view_pets/data/repositories/pet_repo.dart';
import 'package:pet_finder/features/view_pets/presentation/bloc/pet_cubit.dart';
import 'package:pet_finder/features/view_pets/presentation/bloc/pet_state.dart';
import 'package:dio/dio.dart';

class ViewPetsPage extends StatelessWidget {
  const ViewPetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetCubit(
        repo: PetRepo(service: PetService(Dio())),
        apiKey: ApiConstants.apiKey,
      )..fetchAllPets(),
      child: const _ViewPetsPageBody(),
    );
  }
}

class _ViewPetsPageBody extends StatefulWidget {
  const _ViewPetsPageBody();

  @override
  State<_ViewPetsPageBody> createState() => _ViewPetsPageBodyState();
}

class _ViewPetsPageBodyState extends State<_ViewPetsPageBody> {
  String _activeCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Find Your Forever Pet',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategory('All'),
                  _buildCategory('Cats'),
                  _buildCategory('Dogs'),
                  _buildCategory('Birds'),
                  _buildCategory('Fish'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<PetCubit, PetState>(
                builder: (context, state) {
                  if (state is PetLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PetLoaded) {
                    return ListView.builder(
                      itemCount: state.pets.length,
                      itemBuilder: (context, index) {
                        final pet = state.pets[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  pet.url ?? '',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                pet.name ?? 'No Name',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('${pet.gender ?? 'Unknown'} • ${pet.age ?? 'Unknown'}'),
                              trailing: const Icon(Icons.favorite_border),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is PetError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('No pets found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String text) {
    final bool isActive = _activeCategory == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeCategory = text;
        });
        context.read<PetCubit>().filterPetsByCategory(text);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
