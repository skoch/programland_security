CREATE TABLE `staff_list` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT,
  `short_name` varchar(20) NOT NULL,
  `full_name` varchar(20) NOT NULL,
  `role` varchar(20) NOT NULL,
  `affiliations` varchar(50) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `status` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`)
)

INSERT INTO `staff_list` VALUES(1, 'mlebowitz', 'Michael Lebowitz', 'CEO-Founder', '*', 'm.lebowitz@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(2, 'jhirsch', 'Joshua Hirsch', 'Minister of Technology', 'coders,*', 'j.hirsch@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(3, 'dchau', 'Dave Chau', 'Design Director', 'designers,cheapies', 'd.chau@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(4, 'sjason', 'S. Jason Prohaska', 'GM', '*', 's.jason@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(5, 'jkosoy', 'Jamie Kosoy', 'Associate Technical Director', 'coders,bears', 'j.kosoy@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(6, 'tdamman', 'Tyson Damman', 'Sr. Art Director', 'designers,bears', 't.damman@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(7, 'mdelosreyes', 'Mike Delosreyes', 'QA Lead', 'coders,qa', 'm.delosreyes@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(8, 'skoch', 'Stephen Koch', 'Sr. Developer', 'coders,cheapies', 's.koch@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(9, 'sahmed', 'Sabah Ahmed', 'Producer', 'producers,bears', 's.ahmed@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(10, 'nloffredo', 'Nikki Loffredo', 'EA to Michael Lebowitz / Office Admin', '*', 'n.loffredo@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(11, 'jhart', 'Jason Hart', 'Sr. Art Director', 'designers,squids', 'j.hart@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(12, 'jce', 'James Ce', 'IT Engineer', 'IT', 'j.ce@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(13, 'npeters', 'Nathan Peters', 'Designer', 'designers,squids', 'n.peters@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(14, 'rheuer', 'Ranae Heuer', 'VP Client Services', 'producers,*', 'r.heuer@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(15, 'bbojko', 'Benjamin Bojko', 'Developer', 'coders,bears', 'b.bojko@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(16, 'vpineiro', 'Victor Pineiro', 'Strategist', 'strategy', 'v.pineiro@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(17, 'jquercia', 'Jay Quercia', 'Designer', 'designers,cheapies', 'j.quercia@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(18, 'jteixeira', 'Josh Teixeira', 'Sr. Strategist', 'strategy', 'j.teixeira@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(19, 'acumming', 'Alec Cumming', 'Developer', 'coders,bears', 'a.cumming@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(20, 'bbeacham', 'Becca Beacham', 'Client Services Manager', 'clients,*', 'b.beacham@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(21, 'lbrady', 'Lindsay Brady', 'Producer', 'producers,stephanies', 'l.brady@bigspaceship.com', 'asdzxc;', 0);


INSERT INTO `staff_list` VALUES(1, 'mlebowitz', 'Michael Lebowitz', 'CEO-Founder', '*', 'm.lebowitz@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(2, 'jhirsch', 'Joshua Hirsch', 'Minister of Technology', 'coders,*', 'j.hirsch@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(3, 'dchau', 'Dave Chau', 'Design Director', 'designers,cheapies', 'd.chau@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(4, 'sjason', 'S. Jason Prohaska', 'GM', '*', 's.jason@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(5, 'jkosoy', 'Jamie Kosoy', 'Associate Technical Director', 'coders,bears', 'j.kosoy@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(6, 'tdamman', 'Tyson Damman', 'Sr. Art Director', 'designers,bears', 't.damman@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(7, 'rwatts', 'Rob Watts', 'Sr. Producer', 'producers,*', 'r.watts@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(8, 'mdelosreyes', 'Mike Delosreyes', 'QA Lead', 'coders,qa', 'm.delosreyes@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(9, 'skoch', 'Stephen Koch', 'Sr. Developer', 'coders,cheapies', 's.koch@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(10, 'sahmed', 'Sabah Ahmed', 'Producer', 'producers,bears', 's.ahmed@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(11, 'scalvillo', 'Sarah Calvillo', 'Sr. Designer', 'designers,stephanies', 's.calvillo@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(12, 'iaskwith', 'Ivan Askwith', 'Director of Strategy', 'strategy', 'i.askwith@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(13, 'cpetrillo', 'Chris Petrillo', 'Designer', 'designers,cheapies', 'c.petrillo@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(14, 'nloffredo', 'Nikki Loffredo', 'EA to Michael Lebowitz / Office Admin', '*', 'n.loffredo@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(15, 'jhart', 'Jason Hart', 'Sr. Art Director', 'designers,squids', 'j.hart@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(16, 'dscheibel', 'Daniel Scheibel', 'Sr. Developer', 'coders,robots', 'd.scheibel@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(17, 'jce', 'James Ce', 'IT Engineer', 'IT', 'j.ce@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(18, 'sheuer', 'Shannon Heuer', 'Producer', 'producers,robots', 's.heuer@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(19, 'npeters', 'Nathan Peters', 'Designer', 'designers,squids', 'n.peters@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(20, 'cwhitney', 'Charlie Whitney', 'Sr. Developer', 'coders,squids', 'c.whitney@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(21, 'rheuer', 'Ranae Heuer', 'VP Client Services', 'producers,*', 'r.heuer@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(22, 'datkinson', 'Damian Atkinson', 'Sr. Designer', 'designers,bears', 'd.atkinson@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(23, 'bbojko', 'Benjamin Bojko', 'Developer', 'coders,bears', 'b.bojko@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(24, 'vpineiro', 'Victor Pineiro', 'Strategist', 'strategy', 'v.pineiro@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(25, 'dmall', 'Dan Mall', 'Sr. Designer', 'designers,coders,stephanies', 'd.mall@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(26, 'aito', 'Ayaka Ito', 'Designer', 'designers,stephanies', 'a.ito@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(27, 'ccocca', 'Chris Cocca', 'Sr. Strategist', 'strategy', 'c.cocca@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(28, 'jquercia', 'Jay Quercia', 'Designer', 'designers,cheapies', 'j.quercia@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(29, 'jmorrill', 'Jeramy Morrill', 'Art Director', 'designers,coders,stephanies', 'j.morrill@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(30, 'jvladimirsky', 'Jen Vladimirsky', 'Associate Producer', 'producers,cheapies', 'j.vladimirsky@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(31, 'jteixeira', 'Josh Teixeira', 'Sr. Strategist', 'strategy', 'j.teixeira@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(32, 'acumming', 'Alec Cumming', 'Developer', 'coders,bears', 'a.cumming@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(33, 'bbeacham', 'Becca Beacham', 'Client Services Manager', 'clients,*', 'b.beacham@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(34, 'emchugh', 'Erin McHugh', 'Strategy Intern', 'strategy', 'e.mchugh@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(35, 'jriddle', 'Jarrod Riddle', 'Sr. Art Director', 'designers,robots', 'j.riddle@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(36, 'lrosenblatt', 'Laura Rosenblatt', 'Producer Intern', 'producers,robots', 'l.rosenblatt@bigspaceship.com', 'asdzxc;', 0);
INSERT INTO `staff_list` VALUES(37, 'lbrady', 'Lindsay Brady', 'Producer', 'producers,stephanies', 'l.brady@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(38, 'nsalamone', 'Nicole Salamone', 'Acct Lead / Producer : GE', 'producers,cheapies', 'n.salamone@bigspaceship.com', 'asdzxc;', 0);
-- INSERT INTO `staff_list` VALUES(39, 'zbolton', 'Zachary Bolton', 'Sr. Producer / Acct Lead', 'producers,squids', 'z.bolton@bigspaceship.com', 'asdzxc;', 0);
