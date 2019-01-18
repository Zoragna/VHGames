using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SelectCharacter : MonoBehaviour
{

    public static bool Persotest1Enable = false;

    public static bool Persotest2Enable = false;

    public void LoadPersotest1()
    {
        SceneManager.LoadScene("test");
        Persotest1Enable = true;
    }

    public void LoadPersotest2()
    {
        SceneManager.LoadScene("test");
        Persotest2Enable = true;
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
