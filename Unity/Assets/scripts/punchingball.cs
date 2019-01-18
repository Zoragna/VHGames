using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class punchingball : MonoBehaviour
{
    public int punching_ball_health;
    public GameObject PunchingBall;

    public void take_dammage(int dammage)
    {
       punching_ball_health -= dammage;
        Debug.Log(punching_ball_health);

        if (punching_ball_health <= 0)
        {
            
            Destroy(gameObject);

        }
    }

 
}
