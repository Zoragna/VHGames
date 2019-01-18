using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;



public class MainMenu : MonoBehaviour
{
    public bool OptionsEnable = false;
    public GameObject OptionsObject;

    public bool MenuEnable = true;
    public GameObject MenuObject;

    public void LoadMap ()
    {
        SceneManager.LoadScene("map");
    }

    public void EnableOptions()
    {
        OptionsEnable = !OptionsEnable;
        MenuEnable = !MenuEnable;
    }

    private void Update()
    {
        if (OptionsEnable== true)
        {
            OptionsObject.SetActive(true);
            MenuObject.SetActive(false);
        }
        else
        {
            OptionsObject.SetActive(false);
            MenuObject.SetActive(true);
        }
    }

    public void QuitGame()
    {
        Application.Quit();
    }
}
