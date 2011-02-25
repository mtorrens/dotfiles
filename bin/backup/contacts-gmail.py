#!/usr/bin/env python

import getpass
import atom
import gdata.contacts.data
import gdata.contacts.client
import vobject

if __name__ == "__main__":
    password = getpass.getpass('Enter Google password: ')
    
    client = gdata.contacts.client.ContactsClient(source='charlespence.net-backup-v1')
    client.ClientLogin('charles@charlespence.net', password, client.source)
    
    fp = open('contacts.vcf', 'w')
    
    query = gdata.contacts.client.ContactsQuery()
    query.max_results = 9999
    feed = client.GetContacts(q=query)
        
    for i, entry in enumerate(feed.entry):
        if entry.deleted:
            continue
        
        vcard = vobject.vCard()
        
        if entry.name:
            if entry.name.family_name:
                family = entry.name.family_name.text
            else:
                family = ''
            if entry.name.given_name:
                given = entry.name.given_name.text
            else:
                given = ''
            if entry.name.additional_name:
                additional = entry.name.additional_name.text
            else:
                additional = ''
            if entry.name.name_prefix:
                prefix = entry.name.name_prefix.text
            else:
                prefix = ''
            if entry.name.name_suffix:
                suffix = entry.name.name_suffix.text
            else:
                suffix = ''
            
            vcard.add('n')
            vcard.n.value = vobject.vcard.Name(family=family, given=given,
                additional=additional, prefix=prefix, suffix=suffix)
            
            if entry.name.full_name:
                vcard.add('fn')
                vcard.fn.value = entry.name.full_name.text
        
        for i, email in enumerate(entry.email):
            vcard.add('email')
            vcard.email_list[i].value = email.address
            vcard.email_list[i].type_paramlist = ['INTERNET']
            if email.primary:
                vcard.email_list[i].type_paramlist.append('PREF')
            if email.rel:
                if email.rel.endswith('home'):
                    vcard.email_list[i].type_paramlist.append('HOME')
                elif email.rel.endswith('work'):
                    vcard.email_list[i].type_paramlist.append('WORK')
        
        if entry.organization:
            if entry.organization.name:
                vcard.add('org')
                vcard.org.value = entry.organization.name.text
            
            if entry.organization.job_description:
                vcard.add('role')
                vcard.role.value = entry.organization.job_description.text
            
            if entry.organization.title:
                vcard.add('title')
                vcard.title.value = entry.organization.title.text
        
        for i, phone in enumerate(entry.phone_number):
            vcard.add('tel')
            vcard.tel_list[i].value = phone.text
            vcard.tel_list[i].type_paramlist = []
            
            if phone.rel:
                rel = phone.rel
                
                if rel.find('#home') != -1:
                    vcard.tel_list[i].type_paramlist.append('HOME')
                elif rel.find('#work') != -1:
                    vcard.tel_list[i].type_paramlist.append('WORK')
                elif rel.find('#mobile') != -1:
                    vcard.tel_list[i].type_paramlist.append('CELL')
                if rel.endswith('_mobile'):
                    vcard.tel_list[i].type_paramlist.append('CELL')
                
                if rel.endswith('_fax'):
                    vcard.tel_list[i].type_paramlist.append('FAX')
                elif rel.endswith('pager'):
                    vcard.tel_list[i].type_paramlist.append('PAGER')
                else:
                    vcard.tel_list[i].type_paramlist.append('VOICE')
                
            if phone.primary:
                vcard.tel_list[i].type_paramlist.append('PREF')
        
        for i, adr in enumerate(entry.structured_postal_address):
            
            vcard.add('label')
            if adr.formatted_address:
                vcard.label_list[i].value = adr.formatted_address.text
            
            # TYPE: postal, home, work, pref
            vcard.label_list[i].type_paramlist = ['POSTAL'];
            if adr.rel.endswith('#home'):
                vcard.label_list[i].type_paramlist.append('HOME')
            elif adr.rel.endswith('#work'):
                vcard.label_list[i].type_paramlist.append('WORK')
            
            if adr.primary:
                vcard.label_list[i].type_paramlist.append('PREF')
        
        for i, im in enumerate(entry.im):
            valname='X-UNKNOWN-IM'
            
            if im.protocol.endswith('AIM'):
                valname='X-AIM'
            elif im.protocol.endswith('MSN'):
                valname='X-MSN'
            elif im.protocol.endswith('YAHOO'):
                valname='X-YAHOO'
            elif im.protocol.endswith('SKYPE'):
                valname='X-SKYPE'
            elif im.protocol.endswith('ICQ'):
                valname='X-ICQ'
            elif im.protocol.endswith('GOOGLE_TALK'):
                valname='X-GOOGLE-TALK'
            elif im.protocol.endswith('JABBER'):
                valname='X-JABBER'
            
            vcard.add(valname).value = im.address.text
        
        for i, url in enumerate(entry.website):
            vcard.add('url').value = url.href
        
        if entry.birthday:
            vcard.add('bday').value = entry.birthday.when
        
        if entry.nickname:
            vcard.add('nickname').value = entry.nickname.text
        
        for i, event in enumerate(entry.event):
            if event.rel == 'anniversary':
                vcard.add('X-ANNIVERSARY').value = event.when.start
        
        keys = {
            'assistant': 'X-ASSISTANT',
            'brother': 'X-BROTHER',
            'child': 'X-CHILD',
            'domestic-partner': 'X-SPOUSE',
            'father': 'X-FATHER',
            'friend': 'X-FRIEND',
            'manager': 'X-MANAGER',
            'mother': 'X-MOTHER',
            'parent': 'X-PARENT',
            'sister': 'X-SISTER',
            'spouse': 'X-SPOUSE'
        }
        
        for i, rel in enumerate(entry.relation):
            if rel.rel in keys:
                vcard.add(keys[rel.rel]).value = rel.text        
        
        if entry.content:
            vcard.add('note').value = entry.content.text
        
        if not hasattr(vcard, 'fn'):
            if vcard.org:
                vcard.add('fn')
                vcard.fn.value = vcard.org.value
            else:
                sys.stderr.write('ERROR: vCard without both name and organization?')
                continue
        
        if not hasattr(vcard, 'n'):
            if vcard.org:
                vcard.add('n')
                vcard.n.value = vobject.vcard.Name(vcard.org.value)
            else:
                sys.stderr.write('ERROR: vCard without both name and organization?')
                continue
        
        fp.write(vcard.serialize())
    
    fp.close()

