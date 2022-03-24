using numl.Model;

public class Tennis {
    [Feature]
    public Outlook Outlook { get; set; }

    [Feature]
    public Temperature Temperature { get; set; }

    [Feature]
    public bool Windy { get; set; }

    [Label]
    public bool Play { get; set; }

    public override string ToString() {

        return string.Format("The result is {0}", Play);

    }

}

public enum Outlook {
    Sunny,

    Overcast,

    Rainy
}

public enum Temperature {
    Low,

    High
}