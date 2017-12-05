﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IrcDotNet;

namespace Meridian59.Bot.IRC
{
    public class IRCAdminBotCommandCheckReg : IRCAdminBotCommand
    {
        public const string HELPSTRING = "@checkreg nickname: Check if nick is registered.";
        public const string COMMAND = "@checkreg";

        public override IRCAdminBotCommandType CommandType { get { return IRCAdminBotCommandType.CheckReg; } }

        public IRCAdminBotCommandCheckReg()
        {
        }

        /// <summary>
        /// Performs command
        /// </summary>
        /// <returns></returns>
        public override bool PerformCommand(string Admin, string Command, IRCBotClient Bot)
        {
            Bot.IrcClient.LocalUser.SendMessage(Admin, Command
                + (Bot.IsUserRegistered(Command) ? " is registered." : " is not registered."));

            return true;
        }
    }
}
