from genetics import *

if __name__ == '__main__':

    graph = Graph.from_file("graph.txt")
    population = Population(graph)
    stats = population.evolve_until_done()

    print("Generations:", stats.generation)
    print("Fitness:", stats.fitness)
    print("Vertices:", [x for x in stats.clique])
