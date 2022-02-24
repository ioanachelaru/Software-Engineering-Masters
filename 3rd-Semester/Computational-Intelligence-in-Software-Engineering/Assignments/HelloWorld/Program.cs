using System;
using numl.Model;
using numl.Supervised.DecisionTree;

namespace ConsoleApplication
{
    public class Program
    {
        public static void hello_world() {
            Console.WriteLine("Hello World!");

            var description = Descriptor.Create<Iris>();
            Console.WriteLine(description);

            var generator = new DecisionTreeGenerator();
            var data = Iris.Load();
            var model = generator.Generate(description, data);
            
            Console.WriteLine("Generated model:");
            Console.WriteLine(model);
        }


        public static Tennis[] GetData() {

            return new Tennis[] {
                new Tennis { Play = true, Outlook=Outlook.Sunny, Temperature = Temperature.Low, Windy=true},
                new Tennis { Play = false, Outlook=Outlook.Sunny, Temperature = Temperature.High, Windy=true},
                new Tennis { Play = false, Outlook=Outlook.Sunny, Temperature = Temperature.High, Windy=false},
                new Tennis { Play = true, Outlook=Outlook.Overcast, Temperature = Temperature.Low, Windy=true},
                new Tennis { Play = true, Outlook=Outlook.Overcast, Temperature = Temperature.High, Windy= false},
                new Tennis { Play = true, Outlook=Outlook.Overcast, Temperature = Temperature.Low, Windy=false},
                new Tennis { Play = false, Outlook=Outlook.Rainy, Temperature = Temperature.Low, Windy=true},
                new Tennis { Play = true, Outlook=Outlook.Rainy, Temperature = Temperature.Low, Windy=false}
            };

        }

        public static void run() {
            var data = GetData();

            var d = Descriptor.Create<Tennis>();
            
            var g = new DecisionTreeGenerator(d);
            g.SetHint(false);

            var model = numl.Learner.Learn(data, 0.80, 1000, g);
            Console.WriteLine(model);

            var result = model.Model.Predict(new Tennis { Outlook = Outlook.Rainy, Windy = true });
            Console.WriteLine(result);
        }

        public static void Main(string[] args) {
            hello_world();
            
            run();
        }
    
    }
}
