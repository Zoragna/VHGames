using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static SelectCharacter;

public class characterspawn : MonoBehaviour
{
    public Transform SpawnPerso;
    public GameObject Persotest1Object;
    public GameObject Persotest2Object;

    // Update is called once per frame
    void Start()
    {
        if (Persotest1Enable== true)
        {
            Instantiate(Persotest1Object, SpawnPerso.position, SpawnPerso.rotation);
        }

        if (Persotest2Enable == true)
        {
            Instantiate(Persotest2Object, SpawnPerso.position, SpawnPerso.rotation);
        }
    }
}
