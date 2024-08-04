#!/bin/bash
# Суббота или воскресенье?
if [ $(date +%a) = "Sat" ] || [ $(date +%a) = "Sun" ]; then
    # Входит ли пользователь в admin?
    if getent group admin | grep -qw "$PAM_USER"; then
        #Если пользователь входит в группу admin, то он может подключиться
        exit 0
    else
        #Иначе ошибка (не сможет подключиться)
        exit 1
    fi
  #Если день не выходной, то подключиться может любой пользователь
else
    exit 0
fi


