# -*- coding: utf-8 -*-
'''
Created on Sep 25, 2012

@author: moloch

    Copyright 2012 Root the Box

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
'''


import json

from BaseHandlers import BaseHandler
from models import dbsession, MarketItem, Permission, Team
from libs.Notifier import Notifier
from libs.SecurityDecorators import authenticated


class MarketViewHandler(BaseHandler):
    ''' Renders views of items in the market '''

    @authenticated
    def get(self, *args, **kwargs):
        ''' Renders the main table '''
        user = self.get_current_user()
        self.render('market/view.html', user=user, errors=None)

    @authenticated
    def post(self, *args, **kwargs):
        ''' Called to purchase an item '''
        try:
            uuid = self.get_argument('uuid')
        except:
            uuid = ""
        item = MarketItem.by_uuid(uuid)
        if item != None:
            user = self.get_current_user()
            team = Team.by_id(user.team.id) # Refresh object
            if user.has_permission(item.permission_name):
                self.render('market/view.html', user=user, errors=["You have already purchased this item."])
            elif team.money < item.price:
                message = "You only have $%d you cannot afford to purchase this item." % (team.money,)
                self.render('market/view.html', user=user, errors=[message])
            else:
                self.purchase_item(team, item)
                message = "%s purchased %s from the black market." % (user.handle, item.name)
                Notifier.team_success(team, "Upgrade Purchased", message)
                self.redirect('/market')
        else:
            self.render('market/view.html', user=user, errors=["Item does not exist."])

    def purchase_item(self, team, item):
        ''' Conducts the actual purchase of an item '''
        team.money -= item.price
        dbsession.add(team)
        for member in team.members:
            perm = Permission(
                user_id=member.id,
                name=item.permission_name,
            )
            dbsession.add(perm)
        dbsession.flush()


class MarketDetailsHandler(BaseHandler):
    ''' Renders views of items in the market '''

    @authenticated
    def get(self, *args, **kwargs):
        ''' Get details on an item '''
        try:
            uuid = self.get_argument('uuid')
        except:
            uuid = ""
        item = MarketItem.by_uuid(uuid)
        if item == None:
            self.write({'Error': 'Item does not exist.'})
        else:
            self.write(item.to_json())
        self.finish()